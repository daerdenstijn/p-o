library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adc_decoder is
	Port (
		rst : in STD_LOGIC;
		adc_in : in  integer range -33000 to 33000;
		adc_val : out  STD_LOGIC_VECTOR (2 downto 0);
		clk : in  STD_LOGIC
	);
end adc_decoder;

architecture Behavioral of adc_decoder is

--signal adc_in: signed(15 downto 0) := (others => '0');

begin
--for signed bit
--process (clk) begin
--		if clk'event and clk='1' then
--			case adc_in is
--				when "1111111111111111" => adc_val <= "000";
--				when "1111111101111111" => adc_val <= "001";
--				when "1111110111111111" => adc_val <= "010";
--				when "1110111111111111" => adc_val <= "011";
--				when "1100111111111111" => adc_val <= "100";
--				when "1111111111011111" => adc_val <= "101";
--				when "1101111111111111" => adc_val <= "110";
--				when others   => adc_val <= "111";
--			end case;
--		end if;
--	end process;
	
	process (clk) begin
		if rst = '1' then
		adc_val <= "000";
		elsif clk'event and clk='1' then
			if adc_in < - 24750 then
				adc_val <= "000";
			elsif adc_in < - 16500 then
				adc_val <= "001";
			elsif adc_in < - 8250 then
				adc_val <= "010";
			elsif adc_in < 0 then
				adc_val <= "011";
			elsif adc_in < 8250 then
				adc_val <= "100";
			elsif adc_in < 16500 then
				adc_val <= "101";
			elsif adc_in < 24750 then
				adc_val <= "110";
			else
				adc_val <= "111";
			end if;		
		end if;
	end process;

end Behavioral;

