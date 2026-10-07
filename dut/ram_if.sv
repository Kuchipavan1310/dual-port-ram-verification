interface ram_if(input bit clock);

  // Signals
  bit         write_en;
  bit         read_en;
  logic [31:0] write_data;
  logic [31:0] read_data;
  logic [7:0] write_addr;
  logic [7:0] read_addr;

  // Write Driver Clocking Block
  clocking w_drv_cb @(posedge clock);
    default input #1 output #1;
    output write_en, write_addr, write_data;
  endclocking

  // Read Driver Clocking Block
  clocking r_drv_cb @(posedge clock);
    default input #1 output #1;
    output read_en, read_addr;
    input  read_data;
  endclocking

  // Write Monitor Clocking Block
  clocking w_mon_cb @(posedge clock);
    default input #1 output #1;
    input write_en, write_addr, write_data;
  endclocking

  // Read Monitor Clocking Block
  clocking r_mon_cb @(posedge clock);
    default input #1 output #1;
    input read_en, read_addr, read_data;
  endclocking

  // Modports
  modport write_drv (clocking w_drv_cb);
  modport read_drv  (clocking r_drv_cb);
  modport write_mon (clocking w_mon_cb);
  modport read_mon  (clocking r_mon_cb);

endinterface
