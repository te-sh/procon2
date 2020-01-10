import std.algorithm, std.conv, std.file, std.process;
import std.regex, std.stdio, std.string, std.typecons, std.uni;

void main()
{
  auto path = Path("SITES"), url = Url();

  while (true) {
    path.setFromINotify(readln.chomp);
    if (!path.valid || !path.changed) continue;

    writeln("==================== ", path);

    url.setFromFile(path);
    if (!url.valid) continue;

    if (url.changed)
      if (runProcess(["./oj-download", url])) continue;

    auto env = ["SITE": path.site.toUpper];
    if (runProcess(["./dmd-compile", path], env)) continue;
    runProcess(["./oj-test"], env);
  }
}

struct Path
{
  string path, prevPath, site;
  long time, prevTime;
  bool valid;
  string[] sites;
  alias path this;

  auto this(string envName) { sites = environment.get(envName).split; }

  auto setFromINotify(string s)
  {
    auto m = s.matchFirst(r"(\d+) (/.*?/(.*?)/.*)");
    if (!m.empty) {
      prevTime = time;
      prevPath = path;
      time = m[1].to!long;
      path = m[2].to!string;
      site = m[3].to!string;
      valid = exists(path) && !isDir(path) && sites.canFind(site);
      if (valid) sleep();
    } else {
      valid = false;
    }
  }

  auto sleep()
  {
    // Some editors notify several notifications during short time
    // and the notificated file may disappear in the moment.
    import core.thread;
    Thread.sleep(dur!("msecs")(200));
  }

  auto changed()
  {
    return path != prevPath || time - prevTime > 2;
  }
}

struct Url
{
  string url, prevUrl;
  bool valid;
  alias url this;

  auto setFromFile(string path)
  {
    auto file = File(path, "r");
    scope(exit) file.close();
    foreach (line; file.byLine) {
      auto m = line.matchFirst(r"// URL: (.*)");
      if (!m.empty) {
        prevUrl = url;
        url = m[1].to!string;
        valid = true;
        return;
      }
    }
    valid = false;
  }

  auto changed() { return url != prevUrl; }
}

auto runProcess(string[] cmd, string[string] env = null)
{
  auto pid = spawnShell(cmd.join(" "), env);
  return wait(pid);
}
