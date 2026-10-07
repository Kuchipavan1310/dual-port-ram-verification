class ram_sb;

  ram_trans t1, t2;

  mailbox #(ram_trans) mbx1, mbx2;

  function new(mailbox #(ram_trans) mbx1, mailbox #(ram_trans) mbx2);
    this.mbx1 = mbx1;
    this.mbx2 = mbx2;
  endfunction

  task run();

    forever begin
      
      fork
        mbx1.get(t1); // Actual from RMON
        mbx2.get(t2); // Expected from RM
      join

      if(t1.read_addr != t2.read_addr)
        $display("[SB] Address Mismatch");
      else if(t1.read_data != t2.read_data)
        $display("[SB] Data Mismatch");
      else
        $display("[SB] Data Matched Successfully");

    end

  endtask

endclass
