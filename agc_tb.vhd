--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:05:41 04/30/2021
-- Design Name:   
-- Module Name:   /users/start2016/r0634216/gmsk100-digital/xilinx/gmsk100_example/agc_tb.vhd
-- Project Name:  gmsk100_example
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: agc
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY agc_tb IS
END agc_tb;
 
ARCHITECTURE behavior OF agc_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT agc
    PORT(
         clk : IN  std_logic;
         rx_data : OUT  std_logic_vector(7 downto 0);
         comp0 : IN  std_logic;
         comp1 : IN  std_logic;
         comp2 : IN  std_logic;
         comp3 : IN  std_logic;
         comp4 : IN  std_logic;
         comp5 : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal comp0 : std_logic := '0';
   signal comp1 : std_logic := '0';
   signal comp2 : std_logic := '0';
   signal comp3 : std_logic := '0';
   signal comp4 : std_logic := '0';
   signal comp5 : std_logic := '0';

 	--Outputs
   signal rx_data : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: agc PORT MAP (
          clk => clk,
          rx_data => rx_data,
          comp0 => comp0,
          comp1 => comp1,
          comp2 => comp2,
          comp3 => comp3,
          comp4 => comp4,
          comp5 => comp5
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

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
