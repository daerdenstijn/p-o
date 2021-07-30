
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity combination is
    Port ( comb_in : in  std_logic_vector(14 downto 0);
           sample : in  STD_LOGIC;
			  clk : in  STD_LOGIC;
           comb_out : out  std_logic_vector(14 downto 0)
			  );
end combination;

architecture Behavioral of combination is

signal bits_out : unsigned(14 downto 0) := (others => '0');
signal previous_data : unsigned(14 downto 0) := (others => '0');
signal data : unsigned(14 downto 0) := (others => '0');
begin

	combination : process(clk)
	begin 
		if rising_edge(clk) then
			if sample = '1' then 
			data <= unsigned(comb_in);
			previous_data <= data;
			bits_out <= data - previous_data;
			end if;
		end if;
	end process combination;
	comb_out <= std_logic_vector(bits_out);
	
	
end Behavioral;

