working_directory ""
worker_processes 4
listen "/var/run/unicorn/jrf_website_unicorn.sock", backlog: 64
pid "/var/run/unicorn/jrf_website_unicorn.pid"
stderr_path "/var/log/jrf_website_unicorn.stderr.log"
stdout_path "/var/log/jrf_website_unicorn.stdout.log"
