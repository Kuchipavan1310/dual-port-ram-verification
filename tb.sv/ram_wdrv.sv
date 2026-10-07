  class ram_wdrv;

    ram_trans t1; //handle to store trans from gen
    mailbox #(ram_trans) mbx1; //gen put() data in mb and wdrv get() data from driver
    virtual ram_if.write_drv vif;

    //stores mailbox and vif handles inside the driver
    function new(mailbox #(ram_trans) mbx1, virtual ram_if.write_drv vif);
      this.mbx1 = mbx1;
      this.vif  = vif;
    endfunction

    task run();

      forever begin

        mbx1.get(t1);

        vif.w_drv_cb.write_en <= 1'b1;

        repeat(2)
          @(vif.w_drv_cb);

        vif.w_drv_cb.write_addr <= t1.write_addr;
        vif.w_drv_cb.write_data <= t1.write_data;

        repeat(2)
          @(vif.w_drv_cb);

        vif.w_drv_cb.write_en <= 1'b0;

      end

    endtask

  endclass
