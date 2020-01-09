import std.algorithm, std.conv, std.file, std.process;
import std.regex, std.stdio, std.string, std.typecons, std.uni;

void main()
{
  auto prevUrl = "";
  auto sites = environment.get("SITES").split;

  while (true) {
    auto path = readln.chomp;
    if (!exists(path) || isDir(path)) continue;

    auto site = getSite(path);
    if (!sites.canFind(site)) continue;

    writeln("==================== ", path);

    auto url = getUrl(path);
    if (url.empty) continue;

    if (url != prevUrl) {
      if (runProcess(["./oj-download", url])) continue;
      prevUrl = url;
    }

    auto env = ["SITE": site.toUpper];
    if (runProcess(["./dmd-compile", path], env)) continue;
    runProcess(["./oj-test"], env);
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

auto runProcess(string[] cmd, string[string] env = null)
{
  auto pid = spawnShell(cmd.join(" "), env);
  return wait(pid);
}
