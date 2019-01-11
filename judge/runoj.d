import std.stdio, std.file, std.process;
import std.string, std.regex, std.json, std.conv;

void main()
{
  auto config = readText("config.json").parseJSON;
  auto prevUrl = "";

  while (true) {
    auto line = readln.split;
    auto path = line[0] ~ line[2], site = getSite(path);
    if (site !in config) continue;

    auto url = getUrl(path);
    if (url.empty) continue;

    if (url != prevUrl) {
      downloadTest(url);
      prevUrl = url;
    }

    compile(path, config[site]);
  }
}

auto getSite(string path)
{
  return path.split('/')[2];
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
  if (exists("test")) rmdirRecurse("test");
  writeln("=============== Download Test");
  runProcess(["oj", "download", url]);
}

const rootDir = "/root/dlang";

auto compile(string path, JSONValue config)
{
  writeln("=============== Compile");

  auto env = ["PATH": rootDir ~ config["compilerDir"].str,
              "LIBRARY_PATH": rootDir ~ config["libraryDir"].str,
              "LD_LIBRARY_PATH": rootDir ~ config["libraryDir"].str];
  auto opt = config["compileOption"].str.split;

  runProcess(["dmd"] ~ opt ~ ["-of=a.out", path], env);
}

auto runProcess(string[] cmd, string[string] env = null)
{
  auto pipe = pipeProcess(cmd, Redirect.stdout | Redirect.stderrToStdout, env);
  while (true) {
    foreach (line; pipe.stdout.byLine) writeln(line);
    if (tryWait(pipe.pid).terminated) break;
  }
}
