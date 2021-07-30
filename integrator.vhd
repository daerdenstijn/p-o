
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity integrator is
    Port ( int_in : in  std_logic_vector(14 downto 0);
			  clk : in  std_logic;
           int_out : out  std_logic_vector(14 downto 0)
			  );
end integrator;

architecture Behavioral of integrator is

signal bits_out : unsigned(14 downto 0) := (others => '0'); 
begin

	integrator: process(clk)
		begin	
			if rising_edge(clk) then
				bits_out <= bits_out + unsigned(int_in);
			end if;		
	end process integrator;		
	int_out <= std_logic_vector(bits_out);
end Behavioral;

