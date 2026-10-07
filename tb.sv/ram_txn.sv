/* RAM Transaction Packet */

class ram_trans;

  // Randomized fields
  rand bit          write_en;
  rand bit          read_en;
  rand logic [31:0] write_data;
  rand logic [31:0] write_addr;
  rand logic [31:0] read_addr;

  // Response field from DUT
  logic [31:0] read_data;

  // Constraints

  // Write and Read address should not be same
  constraint valid_addr {
    write_addr == read_addr;
  }

  // Limit write data range
  constraint valid_data {
    write_data inside {[1:409]};
  }

  // At least one operation should occur
  constraint valid_en {
    {write_en, read_en} != 2'b00;
  }

  // Copy function
  function ram_trans copy();//resolves handle sharing issues

    copy = new();

    copy.write_en   = this.write_en;
    copy.read_en    = this.read_en;
    copy.write_data = this.write_data;
    copy.read_data  = this.read_data;
    copy.write_addr = this.write_addr;
    copy.read_addr  = this.read_addr;

  endfunction

endclass
