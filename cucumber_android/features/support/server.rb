class Server
  def start(options)
    stop
    `appium -p #{options['port_a']} -bp #{options['portboot_a']} -U #{options['sn_a']} >> logs_a.log 2>&1 &`
    `appium -p #{options['port_b']} -bp #{options['portboot_b']} -U #{options['sn_b']} >> logs_b.log 2>&1 &`
  end

  def stop
    `killall -9 node`
  end
end
