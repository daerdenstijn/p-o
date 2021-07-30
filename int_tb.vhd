library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY int_tb IS
END int_tb;
 
ARCHITECTURE behavior OF int_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT integrator
    PORT(
         int_in : IN  std_logic_vector(5 downto 0);
         clk : IN  std_logic;
         int_out : OUT  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal int_in : std_logic_vector(5 downto 0) := (others => '0');
   signal clk : std_logic := '0';

 	--Outputs
   signal int_out : std_logic_vector(5 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: integrator PORT MAP (
          int_in => int_in,
          clk => clk,
          int_out => int_out
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		int_in <= "000001";
      wait for clk_period;
		int_in <= "000001";
      wait for clk_period;
		int_in <= "000001";
      wait for clk_period;
		int_in <= "000001";
      wait for clk_period;
		int_in <= "000001";
      wait for clk_period;
		int_in <= "000001";
      wait for clk_period;
      -- insert stimulus here 

      wait;
   end process;

END;
