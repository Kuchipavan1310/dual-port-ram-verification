class ram_gen;

  // Declaration
  ram_trans txn, t1, t2;
  //txn = randomized packet tx1 = copy for write driver, tx2	= copy for read driver

  // Mailboxes //2 mb; because for rdrv and wdrv
  mailbox #(ram_trans) mbx1;
  mailbox #(ram_trans) mbx2;

  // Functionality
  function new(
    mailbox #(ram_trans) mbx1,
    mailbox #(ram_trans) mbx2
  );
    this.mbx1 = mbx1;
    this.mbx2 = mbx2;
  endfunction

  // Generator functionality
  task run();

    repeat (2) begin

      txn = new();
      txn.randomize();

      // Create independent copies, rather than assigning directly
      t1 = txn.copy(); 
      t2 = txn.copy();

      // Send to write driver
      mbx1.put(t1);

      // Send to read driver
      mbx2.put(t2);

    end

  endtask

endclass
