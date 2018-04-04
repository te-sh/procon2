require 'fileutils'
require 'listen'

ROOT = '/codes'
WORK_DIR = '/work'
SRC_FILE = 'Main.d'
SRC_PATH = File.join(WORK_DIR, SRC_FILE)
URL = %r{// URL: (.*)}

DOCKER_OJ = 'docker exec -t procon-oj'
DOWNLOAD_CMD = 'oj download %s'
TEST_CMD = 'oj test -c /app/run.sh'

# Tester with online-judge-tool
class OjTester
  def listen
    listener = Listen.to(ROOT) do |modified, added, _removed|
      [modified, added].flatten.each do |file|
        run_test(file) unless file.include?('#')
      end
    end

    listener.start
    sleep
  end

  def run_test(file)
    site = read_site(file)
    return unless site
    url = read_url(file)
    return unless url
    download_test(url)
    copy_src(file)
    return unless build(site)
    run_oj_test
  end

  def read_site(file)
    m = %r{#{ROOT}/(.*?)/.*}.match(file)
    return unless m
    m[1]
  end

  def read_url(file)
    IO.foreach(file) do |line|
      m = URL.match(line)
      return m[1] if m
    end
    nil
  end

  def download_test(url)
    return if @prev_url == url
    FileUtils.rm_rf(File.join(WORK_DIR, 'test'))
    puts '==================== Download'
    system("#{DOCKER_OJ} #{DOWNLOAD_CMD % url}")
    @prev_url = url
  end

  def copy_src(file)
    FileUtils.cp(file, SRC_PATH)
  end

  def build(site)
    puts '==================== Compile'
    system("../build/#{site} #{SRC_FILE}")
  end

  def run_oj_test
    puts '==================== Test'
    system("#{DOCKER_OJ} #{TEST_CMD}")
  end
end

OjTester.new.listen
