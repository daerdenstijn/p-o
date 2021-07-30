library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity nco is

	port(
		clk: in std_logic;
		reset_phase: in std_logic;
		nco_in: in std_logic_vector(23 downto 0); 
		nco_sin: out std_logic_vector(2 downto 0);
		nco_cos: out std_logic_vector(2 downto 0)
		--nco_sine: out std_logic_vector(7 downto 0);
		--nco_cosine: out std_logic_vector(7 downto 0);
		
	);
end nco;

architecture bhv of nco is


constant bits : integer := 8;
constant lut_length :integer := 8; --2**(bits-1);
signal reset : std_logic;
signal freq_control_word : unsigned(23 downto 0);
signal nco_sig : unsigned(23 downto 0);
type lut_sine_out is array(0 to lut_length-1) of std_logic_vector(2 downto 0);
signal test_sig : std_logic_vector(2 downto 0);
constant nco_int : integer := 16777;
constant bits_lut: lut_sine_out := ("100", 
        "110", "111", "110","100","001", "000", "001"
        );




begin		


nco: process(clk)
	begin	
		--if (rst = '0') then 
		if rising_edge(clk) then
			if reset_phase = '0' then
				nco_sig <= (others => '0');
			else 
				freq_control_word <= unsigned(nco_in);
				nco_sig <= nco_sig + freq_control_word;
			end if;	
		end if;
		
	end process nco;




process_sine_wave : process(clk)
begin
 test_sig <= std_logic_vector(nco_sig(23 downto 21));
 nco_sin <= bits_lut(to_integer(unsigned(test_sig)));
 nco_cos <= bits_lut(to_integer(unsigned(test_sig) + 2));

end process process_sine_wave;


end bhv;
