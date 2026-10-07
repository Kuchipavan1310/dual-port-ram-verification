class ram_rdrv;
  
  ram_trans t1;
  mailbox #(ram_trans) mbx1;
  
  virtual ram_if.read_drv vif;
  
  function new(mailbox #(ram_trans) mbx1, virtual ram_if.read_drv vif);
    this.mbx1 = mbx1;
    this.vif = vif;
  endfunction
  
  task run();
    
    forever begin
      mbx1.get(t1);
      vif.r_drv_cb.read_en <= 1'b1;
      
      repeat(2)
        @(vif.r_drv_cb);
      vif.r_drv_cb.read_addr <= t1.read_addr;
      
      repeat(2)
        @(vif.r_drv_cb);
      vif.r_drv_cb.read_en <= 1'b0;
      
    end
    
  endtask
  
endclass
