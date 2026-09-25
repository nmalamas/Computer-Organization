--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:52:12 06/17/2024
-- Design Name:   
-- Module Name:   /home/ise/ise_projects/HRY302_PROJECT3_FULLY_FUNCTIONAL/MUX_2to1_15bits_tb.vhd
-- Project Name:  test_project
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MUX_2to1_15bits
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
 
ENTITY MUX_2to1_15bits_tb IS
END MUX_2to1_15bits_tb;
 
ARCHITECTURE behavior OF MUX_2to1_15bits_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MUX_2to1_15bits
    PORT(
         sel : IN  std_logic;
         IN0 : IN  std_logic_vector(14 downto 0);
         IN1 : IN  std_logic_vector(14 downto 0);
         MUX_OUT : OUT  std_logic_vector(14 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal sel : std_logic := '0';
   signal IN0 : std_logic_vector(14 downto 0) := (others => '0');
   signal IN1 : std_logic_vector(14 downto 0) := (others => '0');
   signal MUX_OUT : std_logic_vector(14 downto 0) := (others => '0');
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MUX_2to1_15bits PORT MAP (
          sel => sel,
          IN0 => IN0,
          IN1 => IN1,
          MUX_OUT => MUX_OUT
        ); 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		 sel <= '0';
		 IN0 <= "000000000000000";
		 IN1 <= "000000000000000";
       wait for 100 ns;	

		 sel <= '1';
		 IN0 <= "000000000001111";
		 IN1 <= "111100000000000";
      wait for 10 ns;

      -- insert stimulus here 

      wait;
   end process;

END;
