class ram_wmon;

  ram_trans t1, t2;
  mailbox #(ram_trans) mbx1;
  virtual ram_if.write_mon vif;

  function new(mailbox #(ram_trans) mbx1, virtual ram_if.write_mon vif);
    this.mbx1 = mbx1;
    this.vif  = vif;
  endfunction

  task run();

    forever begin

      t1 = new();

      repeat(2)
        @(vif.w_mon_cb);
      wait(vif.w_mon_cb.write_en);
      t1.write_addr = vif.w_mon_cb.write_addr;
      t1.write_data = vif.w_mon_cb.write_data;

      repeat(2)
        @(vif.w_mon_cb);
      t2 = t1.copy();
      mbx1.put(t2);

    end

  endtask

endclass
