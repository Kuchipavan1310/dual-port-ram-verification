`include "ram_if.sv"
`include "ram_txn.sv"
`include "ram_gen.sv"
`include "ram_wdrv.sv"
`include "ram_rdrv.sv"
`include "ram_wmon.sv"
`include "ram_rmon.sv"
`include "ram_rm.sv"
`include "ram_sb.sv"
`include "ram_env.sv"
`include "ram_test.sv"

module top;
  
  bit clock = 0;
  
  ram_if intf(clock);
  
  dual_port_ram DUT(.clock(intf.clock),
                    .write_en(intf.write_en),
                    .write_addr(intf.write_addr),
                    .write_data(intf.write_data),
                   
                    .read_en(intf.read_en),
                    .read_addr(intf.read_addr),
                    .read_data(intf.read_data));
  
  ram_test test;
  
  initial begin
    test = new(intf, intf, intf, intf);
    
    test.run();
  end
  
  always
    #5 clock = ~clock;
  
  initial begin
    #200 $finish;
  end
  
endmodule
