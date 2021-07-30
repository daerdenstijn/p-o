
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity multiplexer is
    Port ( mult_in : in  std_logic_vector(2 downto 0);
           osc_in : in  std_logic_vector(2 downto 0);
           mult_out : out  std_logic_vector(2 downto 0));
end multiplexer;

architecture Behavioral of multiplexer is
signal output: std_logic_vector(5 downto 0) := ( others => '0');
begin

output(0) <=  mult_in(0) AND osc_in(0); 
output(1) <= (mult_in(1) AND osc_in(0)) XOR (mult_in(0) AND osc_in(1));
output(2) <= (mult_in(2) AND osc_in(0))XOR((mult_in(0) AND osc_in(2))XOR((NOT(mult_in(0) AND osc_in(0)))AND(mult_in(1) AND osc_in(1))));
output(3) <= (((osc_in(1) XOR osc_in(2)) AND mult_in(1)) XOR (mult_in(2) AND osc_in(1))) XOR ((((NOT(mult_in(0) AND osc_in(0))) AND (mult_in(1) AND osc_in(1))) XOR (mult_in(0) AND osc_in(2))) AND (NOT( mult_in(0) AND osc_in(2))XOR(mult_in(2) AND osc_in(0))));
output(4) <= (NOT(NOT(mult_in(0)) AND (NOT(osc_in(0)) AND ( mult_in(1) AND osc_in(1))))) AND (NOT((( mult_in(1) XOR osc_in(1)) AND ( mult_in(0) AND osc_in(0)))) AND ((((mult_in(0) AND (osc_in(2))) XOR (mult_in(2) AND osc_in(0))) AND (mult_in(1) AND osc_in(1))) XOR ( mult_in(2) AND osc_in(2))));
output(5) <= (mult_in(2) AND osc_in(2))AND(((mult_in(1) XOR osc_in(1))AND(mult_in(0) AND osc_in(0)))XOR(mult_in(1) AND osc_in(1)));
mult_out <= output(5 downto 3);
end Behavioral;

