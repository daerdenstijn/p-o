library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity agc is

	port(
		clk: in std_logic;
		adj: out std_logic_vector(6 downto 0);
		agc_out: out std_logic_vector(4 downto 0);
		agc_in: in std_logic_vector(4 downto 0)
		
	);
end agc;

architecture bhv of agc is

signal count_low : integer range 0 to 51 := 0;
signal count_high : integer range 0 to 51 := 0;
signal adjust: unsigned(6 downto 0) := "0001000";

begin

agc: process(clk)
	begin	
	if rising_edge(clk) then
		if count_high > 19 and to_integer(adjust) > 1 then
			adjust <= shift_right(adjust, 1);	
			count_high <= 0;
		elsif count_low > 19 and to_integer(adjust) < 64 then
			adjust <= shift_left(adjust, 1) ;
			count_low <= 0;
		elsif to_integer(unsigned(agc_in)) < 3 then
			count_low <= count_low + 1;
			count_high <= 0;
		elsif to_integer(unsigned(agc_in)) > 23 then 
			count_high <= count_high + 1;
			count_low <= 0;
		else
			count_high <= 0;
			count_low <= 0;
		end if;	
	end if;	
	adj <= std_logic_vector(adjust);
	agc_out <= agc_in;
	end process agc;
	
end bhv;

