import std.stdio, std.file, std.process, std.typecons;
import std.string, std.regex, std.json, std.conv;

void main()
{
  auto configJson = readText("config.json").parseJSON;
  auto prevUrl = "";

  while (true) {
    auto path = readln.chomp;
    if (!exists(path) || isDir(path)) continue;

    auto site = getSite(path);
    if (site !in configJson) continue;

    writeln("==================== ", path);
    auto config = parseConfig(configJson[site]);
    auto env = config.env, compileOption = config.compileOption;

    auto url = getUrl(path);
    if (url.empty) continue;

    if (url != prevUrl) {
      if (downloadTest(url)) continue;
      prevUrl = url;
    }

    if (compile(path, env, compileOption)) continue;

    runTest(env);
  }
}

auto getSite(string path)
{
  return path.split('/')[2];
}

const rootDir = "/root/dlang/";

auto parseConfig(JSONValue config)
{
  auto dlangDir = rootDir ~ config["dlang"].str;
  auto binDir = config["binDir"].str, libDir = config["libDir"].str;
  auto path = dlangDir ~ binDir ~ ":" ~ environment.get("PATH"), libPath = dlangDir ~ libDir;
  auto env = ["PATH": path, "LIBRARY_PATH": libPath, "LD_LIBRARY_PATH": libPath];
  auto compileOption = config["compileOption"].str.split;
  return tuple!("env", "compileOption")(env, compileOption);
}

auto getUrl(string path)
{
  auto file = File(path);
  foreach (line; file.byLine) {
    auto m = line.matchFirst(r"// URL: (.*)");
    if (!m.empty) return m[1].to!string;
  }
  return "";
}

auto downloadTest(string url)
{
  writeln("---------- Download Test");
  if (exists("test")) rmdirRecurse("test");
  return runProcess(["oj", "download", url]);
}

auto compile(string path, string[string] env, string[] compileOption)
{
  writeln("---------- Compile");
  return runProcess(["dmd"] ~ compileOption ~ [path], env);
}

auto runTest(string[string] env)
{
  writeln("---------- Run Test");
  return runProcess(["oj", "test"], env);
}

auto runProcess(string[] cmd, string[string] env = null)
{
  writeln("> ", cmd.join(" "));
  auto pid = spawnShell(cmd.join(" "), env);
  return wait(pid);
}
