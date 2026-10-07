class ref_model;

  ram_trans t1, t2, t3;

  mailbox #(ram_trans) mbx1;
  mailbox #(ram_trans) mbx2;
  mailbox #(ram_trans) mbx3;

  logic [31:0] mem [int];

  function new(mailbox #(ram_trans) mbx1, mailbox #(ram_trans) mbx2, mailbox #(ram_trans) mbx3);
    this.mbx1 = mbx1;
    this.mbx2 = mbx2;
    this.mbx3 = mbx3;
  endfunction

  task run();

    forever begin

      fork
        begin
          mbx1.get(t1);
          mem[t1.write_addr] = t1.write_data;
        end

        begin
          mbx2.get(t2);
          if(mem.exists(t2.read_addr))
            t2.read_data = mem[t2.read_addr];
          else
            $display("[RM] Address %0d not found", t2.read_addr);
          mbx3.put(t2);
        end
      join

    end

  endtask

endclass
