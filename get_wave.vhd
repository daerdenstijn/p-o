----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:51:40 05/18/2021 
-- Design Name: 
-- Module Name:    get_wave - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity get_wave is
end get_wave;

architecture Behavioral of get_wave is

begin

  process is
    variable line_v : line;
    file read_file : text;
    file write_file : text;
    variable slv_v : std_logic_vector(15 downto 0);
  begin
    file_open(read_file, "waveforms/gmsk_level_0.txt", read_mode);
    --file_open(write_file, "target.txt", write_mode);
    while not endfile(read_file) loop
      readline(read_file, line_v);
      hread(line_v, slv_v);
      report "slv_v: " & to_hstring(slv_v);
      --hwrite(line_v, slv_v);
     -- writeline(write_file, line_v);
    end loop;
    file_close(read_file);
    --file_close(write_file);
    wait;
  end process;

end Behavioral;

