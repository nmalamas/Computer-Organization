----------------------------------------------------------------------------------
-- Company: TUC
-- Engineer: Nikolaos Malamas-Christoforos Oikonmou
-- 
-- Create Date:    15:35:47 03/29/2024 
-- Design Name: 
-- Module Name:    memory_controller - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity memory_controller is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           w : in  STD_LOGIC;
           r : in  STD_LOGIC;
           Valid : out  STD_LOGIC;
			  we : out STD_LOGIC
			  );
end memory_controller;

architecture Behavioral of memory_controller is
type State_type is (I_state, W_state, R_state, WR_state);
signal curr_state: State_type;

begin
process
	begin
	Wait until (CLK'event and CLK = '1');
	if RST = '1' then
		curr_state <= I_state;
	else
		case curr_state is
		
			--IDLE STATE--
			when I_state=> 
				if w='1' and r='0' then
				--Change of state
					curr_state <= W_state;
					
				--Change of ouput(we = NOT valid)
					we <= '1';
					Valid <='0';
				elsif w='0' and r='1' then
				--Change of state
					curr_state <= R_state;
					
				--Change of output(we = NOT valid)
					we <= '0';
					Valid <='1';
				elsif w='1' and r='1' then
				--Change of state
					curr_state <= WR_state;
					
				--Change of output(we = NOT valid)--
					--Read first
					we <= '0';
					Valid <= '1';
					
					--Write last
					we <= '1';
					Valid <= '0';
				else
				-- w=0 and r=0--
				--Change of state
					curr_state <= I_state;
					
				--Change of output(we = NOT valid)--
					Valid <= '0';--r=0
					we <= '1';					
				end if;
			--WRITE STATE--
			when W_state=>
				if w='1' and r='0' then
				--Change of state
					curr_state <= W_state;
					
				--Change of ouput(we = NOT valid)
					we <= '1';
					Valid <='0';
				elsif w='0' and r='1' then
				--Change of state
					curr_state <= R_state;
					
				--Change of output(we = NOT valid)
					we <= '0';
					Valid <='1';
				elsif w='1' and r='1' then
				--Change of state
					curr_state <= WR_state;
					
				--Change of output(we = NOT valid)--
					--Read first
					we <= '0';
					Valid <= '1';
					
					--Write last
					we <= '1';
					Valid <= '0';
				else-- w=0 and r=0
				--CHange of state
					curr_state <= I_state;
					
				--Change of output(we = NOT valid)--
					we <= '1';
					Valid <= '0';
				end if;
			--READ STATE--
			when R_state=>
				if w='1' and r='0' then
				--Change of state
					curr_state <= W_state;
					
				--Change of ouput(we = NOT valid)
					we <= '1';
					Valid <='0';
				elsif w='0' and r='1' then
				--Change of state
					curr_state <= R_state;
					
				--Change of output(we = NOT valid)
					we <= '0';
					Valid <='1';
				elsif w='1' and r='1' then
				--Change of state
					curr_state <= WR_state;
					
				--Change of output(we = NOT valid)--
					--Read first
					we <= '0';
					Valid <= '1';
					
					--Write last
					we <= '1';
					Valid <= '0';
				else-- w=0 and r=0
				--Change of state
					curr_state <= I_state;
					
				--Change of output(we = NOT valid)--
					we <= '1';
					Valid <= '0';
				end if;
			--WRITE_READ STATE--
			when WR_state=>
				if w='1' and r='0' then
				--Change of state
					curr_state <= W_state;
					
				--Change of ouput(we = NOT valid)
					we <= '1';
					Valid <='0';
				elsif w='0' and r='1' then
				--Change of state
					curr_state <= R_state;
					
				--Change of output(we = NOT valid)
					we <= '0';
					Valid <='1';
				elsif w='1' and r='1' then
				--Change of state
					curr_state <= WR_state;
					
				--Change of output(we = NOT valid)--
					--Read first
					we <= '0';
					Valid <= '1';
					
					--Write last
					we <= '1';
					Valid <= '0';
				else-- w=0 and r=0
				--Change of state
					curr_state <= I_state;
					
				--Change of output(we = NOT valid)--
					we <= '1';
					Valid <= '0';
				end if;
		end case;
	end if;
end process;

end Behavioral;

