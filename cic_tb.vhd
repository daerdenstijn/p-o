library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
 
ENTITY cic_tb IS
END cic_tb;
 
ARCHITECTURE behavior OF cic_tb IS 
  
    COMPONENT cic
    PORT(
         cic_in : IN  std_logic_vector;
         clk : IN  std_logic;
			
         cic_out : OUT  std_logic_vector;
         clk_out : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal cic_in : std_logic_vector(2 downto 0) := (others => '0');
   signal clk : std_logic;
   
 	--Outputs
   signal cic_out : std_logic_vector(2 downto 0) := (others => '0');
   signal clk_out : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
   constant clk_out_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: cic PORT MAP (
          cic_in => cic_in,
          clk => clk,
          
          cic_out => cic_out,
          clk_out => clk_out
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
   clk_out_process :process
   begin
		clk_out <= '0';
		wait for clk_out_period/2;
		clk_out <= '1';
		wait for clk_out_period/2;
   end process;
 

   -- Stimulus process
 -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		cic_in <= "000";
		wait for clk_period;
		cic_in <= "001";
		wait for clk_period;
		cic_in <= "111";
		wait for clk_period;
		cic_in <= "111";
		wait for clk_period;
		cic_in <= "001";
		wait for clk_period;
		cic_in <= "001";
		wait for clk_period;
		cic_in <= "101";
		wait for clk_period;
		cic_in <= "101";
		wait for clk_period*10;
		cic_in <= "010";
		wait for clk_period*10;
		cic_in <= "010";
		wait for clk_period;
		cic_in <= "001";
		wait for clk_period;
		cic_in <= "011";
		wait for clk_period;
		cic_in <= "011";
		wait for clk_period;
		cic_in <= "011";
		wait for clk_period;
		cic_in <= "011";
		wait for clk_period;
		cic_in <= "011";
		wait for clk_period;
		cic_in <= "001";
		wait for clk_period*10;
		cic_in <= "010";
		wait for clk_period;
		cic_in <= "100";
		wait for clk_period;
		cic_in <= "101";
		wait for clk_period;
		cic_in <= "110";
		wait for clk_period;
   end process;

END;
