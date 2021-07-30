library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use STD.textio.all; 

ENTITY get_data IS
port(clk:in std_logic;
data_out:out integer range -33000 to 33000
);
END get_data;

ARCHITECTURE behav OF get_data IS 
BEGIN
process (clk) 
  file file_pointer : text;
  variable line_content : integer range -33000 to 33000:=0;
  variable line_num : line;
    variable j : integer := 0;
    variable char : character:='0'; 
    variable cnt:integer range 0 to 2001:=0;
begin

 file_open(file_pointer,"waveforms/gmsk_level_0.txt",READ_MODE);
	if rising_edge(clk) then 
    if cnt<2000 then
  readline (file_pointer,line_num);  
  READ(line_num,line_content);  

        data_out <= line_content;
cnt:=cnt+1;
 end if;
end if;
  file_close(file_pointer);     
end process;
end behav; 