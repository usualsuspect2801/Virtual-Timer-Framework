`timescale 1ns/1ps

class Timer;
  string name;
  int duration;
  int counter;

  function new(string n, int d);
    name = n;
    duration = d;
    counter = 0;
  endfunction

  virtual function void tick(); endfunction
  virtual function bit is_done(); return 0; endfunction
endclass

class PeriodicTimer extends Timer;
  function new(string n, int d);
    super.new(n, d);
  endfunction

  function void tick();
    counter++;
    if (counter == duration) begin
      $display("[%0s] Periodic Tick at time %0t", name, $time);
      counter = 0;
    end
  endfunction
endclass

class OneShotTimer extends Timer;
  bit triggered;
  function new(string n, int d);
    super.new(n, d);
    triggered = 0;
  endfunction

  function void tick();
    if (triggered) return;
    counter++;
    if (counter == duration) begin
      $display("[%0s] One-Shot Fired at time %0t", name, $time);
      triggered = 1;
    end
  endfunction

  function bit is_done();
    return triggered;
  endfunction
endclass

class WatchdogTimer extends Timer;
  bit expired;

  function new(string n, int d);
    super.new(n, d);
    expired = 0;
  endfunction

  function void tick();
    if (expired) return;
    counter++;
    if (counter >= duration) begin
      expired = 1;
      $display("[%0s] Watchdog Expired at time %0t", name, $time);
    end
  endfunction

  function void reset();
    counter = 0;
    expired = 0;
    $display("[%0s] Watchdog Reset at time %0t", name, $time);
  endfunction

  function bit is_done();
    return expired;
  endfunction
endclass
