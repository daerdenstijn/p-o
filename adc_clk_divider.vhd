
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity adc_clk_divider is
	Generic (
		divider_val : positive := 400 -- 50 kHz out by default
	);
	Port (
		clk : in  STD_LOGIC;
		adc_clk : out  STD_LOGIC
	);
end adc_clk_divider;

architecture Behavioral of adc_clk_divider is
	signal counter: unsigned(8 downto 0) := "000000000"; -- max divider 511
begin
	process (clk) begin
		if clk'event and clk='1' then
			counter <= counter + 1;
			
			if counter = (divider_val - 1) then
				counter <= (others => '0');
				adc_clk <= '1';
			else
				adc_clk <= '0';
			end if;
		end if;
	end process;
end Behavioral;

