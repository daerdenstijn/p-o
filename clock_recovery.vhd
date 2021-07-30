library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clock_recovery is

	port(
		clk: in std_logic;
		--rst: in std_logic;
		--i_rx_serial: in std_logic;
		rx_data: out std_logic_vector(2 downto 0);
		data_in: in std_logic_vector(2 downto 0)
	);
end clock_recovery;

architecture bhv of clock_recovery is

type state is (begin_state,start_bit,read_data,read_high,read_low,stop_bit); 

signal current_state : state := begin_state;

constant clocks_per_bit : integer := 9;
constant nbits : integer := 2;
constant bits_per_byte : integer := nbits + 2; -- including start and stop bits
constant osr : integer := 16;


--signal rst : std_logic_vector := "1";
signal count_clock : unsigned(7 downto 0);
signal count_sample : unsigned(7 downto 0); 
signal sampled_bits : unsigned(7 downto 0);
signal count_high : unsigned(7 downto 0); 
signal count_low : unsigned(7 downto 0);
signal sample_pos : std_logic_vector(6*nbits downto 0);

signal q : std_logic_vector(2 downto 0) := ( others => '0');
signal load : std_logic := '0';
signal data_high : std_logic := '0';
signal sample : unsigned(8 downto 0);
signal done : std_logic := '0';
begin		

state_machine: process(clk)
	begin	
	
		if rising_edge(clk) then
		
			---if (rst = '0') then
			--	q <= '0';
			--if load = '1' then
			--	q <= data_in;
			--end if;
		
			case current_state is 
			
				when begin_state =>
					count_sample <= to_unsigned(0, 8);
					sampled_bits <= to_unsigned(0, 8);
					count_high <= to_unsigned(0, 8);
					count_low <= to_unsigned(0, 8);
					count_clock <= to_unsigned(0, 8);
					sample <= to_unsigned(0, 9);
					load <= '0';
					done <= '0';
					if to_integer(unsigned(data_in)) < 3 then
						current_state <= start_bit;
						q <= data_in;
					end if;	

				
				when start_bit =>
						
				if count_clock < 4 and to_integer(unsigned(data_in)) < 3 then
					count_clock <= count_clock + 1;
					sample <= sample +1;
					current_state <= start_bit;
				elsif to_integer(unsigned(data_in)) < 3 then
					count_clock <= to_unsigned(0, 8);
					sample <= sample + 1;
					current_state <= read_data;
					load <= '1';
				else 
					current_state <= begin_state;		
				end if;
					
				when read_data =>		
				data_high <= '0';
				if to_integer(sampled_bits) < nbits then
					if to_integer(unsigned(data_in)) > 4 then
						count_low <= to_unsigned(0, 8);
						count_high <= count_high + 1;
						current_state <= read_high;
						sample <= sample + 1;	
					elsif to_integer(unsigned(data_in)) < 3 then
						count_high <= to_unsigned(0, 8);
						sample <= sample + 1;
						current_state <= read_low;
					else 
						sample <= sample + 1;
						current_state <= read_data;
					end if;
				else 
					count_clock <= to_unsigned(0, 8);
					current_state <= stop_bit;
				end if;
				
				when read_high =>
				if to_integer(count_high) < 3 and to_integer(unsigned(data_in)) > 4 then
					count_low <= to_unsigned(0, 8);
					count_high <= count_high + 1;
					sample <= sample + 1;
					current_state <= read_high;
				elsif to_integer(count_high) >= 3 then
					count_high <= to_unsigned(0, 8);
					data_high <= '1';
					sample <= sample + 1;
					sampled_bits <= sampled_bits + 1;
					current_state <= read_data;
				else 
					count_high <= to_unsigned(0, 8);
					current_state <= read_data;
				end if;	
					
				when read_low =>
				if to_integer(count_low) < 5 and to_integer(unsigned(data_in)) < 3 then
					count_low <= count_low + 1;
					sample <= sample + 1;
					current_state <= read_low;
				elsif to_integer(count_low) >= 5 then 
					count_low <= to_unsigned(0, 8);
					data_high <= '1';
					sample <= sample + 1;
					sampled_bits <= sampled_bits + 1; 
					current_state <= read_data;
				else 
					count_low <= to_unsigned(0, 8);
					current_state <= read_data;	
				end if;

					
			when stop_bit =>
				if to_integer(count_clock) < (clocks_per_bit-1)/2 and to_integer(unsigned(data_in)) < 3 then
					count_clock <= count_clock + 1;
						
				else
					done <= '1';
					current_state <= begin_state;
				end if;
			when others =>
				current_state <= begin_state;
				
			end case;
		end if;
	end process state_machine;
end bhv;


