module testbench;

  PeriodicTimer pt;
  OneShotTimer ot;
  WatchdogTimer wd;

  //  These are real module signals that can go into the waveform
  logic periodic_tick, oneshot_fired, watchdog_expired;

  initial begin
    // Enable waveform dumping
    $dumpfile("wave.vcd");
    $dumpvars(0, testbench); 

    // Instantiate timers
    pt = new("Heartbeat", 5);
    ot = new("Startup", 12);
    wd = new("MainWatchdog", 10);

    periodic_tick = 0;
    oneshot_fired = 0;
    watchdog_expired = 0;

    repeat (20) begin
      $display("Time = %0t", $time);

      // Periodic tick
      pt.tick();
      if (pt.counter == 0) // it resets when it fires
        periodic_tick = ~periodic_tick;

      // One-shot tick
      ot.tick();
      if (ot.is_done())
        oneshot_fired = 1;

      // Watchdog tick
      wd.tick();
      if (wd.is_done())
        watchdog_expired = 1;

      if ($time == 7 || $time == 16)
        wd.reset();

      #1;
    end

    $display("Simulation Complete.");
    $finish;
  end

endmodule
