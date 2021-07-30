library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cic is
    Port ( cic_in : in std_logic_vector;
			  clk : in STD_LOGIC;
           
			  cic_out : out  std_logic_vector;
			  clk_out : out STD_LOGIC);
end cic;

architecture Behavioral of cic is

constant D : natural := 32;
constant N : natural := 3;
constant max_bits : natural :=15;
type array_bits is array (0 to N-1) of std_logic_vector(max_bits - 1 downto 0);


signal integrator_bits : array_bits;
signal combination_bits : array_bits;
signal decimator_count : integer range 0 to D := 0;
signal sample : std_logic := '0';
signal cic_in_large : std_logic_vector(max_bits - 1 downto 0) := (others => '0');

begin
	
	integrator_chain : for i in 0 to N-1 generate	
	
	begin
		
		integr_first : if i = 0 generate
		
		begin 
		
		cic_in_large <= (14 downto cic_in'length => '0') & cic_in;
		
		integr_first_ent : entity work.integrator
		port map(
			int_in => cic_in_large,
			clk => clk,
			int_out => integrator_bits(0)
		);
		end generate integr_first;
		
		integr_second : if i = 1 generate
		
		begin 
		
		integr_second_ent : entity work.integrator
		port map(
			int_in => integrator_bits(0),
			clk => clk,
			int_out => integrator_bits(1)
		);
		end generate integr_second;
		
		integr_third : if i=2 generate
		
		begin 
		
		integr_third_ent : entity work.integrator
		port map(
			int_in => integrator_bits(1),
			clk => clk,
			int_out => integrator_bits(2)
		);
		end generate integr_third;
	end generate integrator_chain;
	
	
	decimator : process(clk)

	begin 

			if rising_edge(clk) then
				clk_out <= '0';
				if decimator_count = (D-1) then
					sample <= '1';
					decimator_count <= 0;
					clk_out <= '1';
				else
					decimator_count <= decimator_count + 1;
					sample <= '0';
					clk_out <= '0';
				end if;
			end if;
	end process decimator;	
		

	combination_chain : for i in 0 to N-1 generate
	
		begin
		
		comb_first : if i=0 generate
		
		begin 
		
		comb_first_ent : entity work.combination
		port map(
			comb_in => integrator_bits(2),
			sample => sample,
			clk => clk,
			comb_out => combination_bits(0)
		);
		end generate comb_first;
		
		comb_second : if i=1 generate
		
		begin 
		
		comb_second_ent : entity work.combination
		port map(
			comb_in => combination_bits(0),
			sample => sample,
			clk => clk,
			comb_out => combination_bits(1)
		);
		end generate comb_second;
		
		comb_third : if i=2 generate
		
		begin 
		
		comb_third_ent : entity work.combination
		port map(
			comb_in => combination_bits(1),
			sample => sample,
			clk => clk,
			comb_out => combination_bits(2)
		);
		end generate comb_third;
	end generate combination_chain;
	cic_out <= combination_bits(2)(14 downto 12);
end Behavioral;