----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.08.2023 19:59:34
-- Design Name: 
-- Module Name: Randomgen - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Randomgen is
 port (
       rand:   out std_logic_vector(3 downto 0);
       clock:  in std_logic
   );
end Randomgen;

architecture Behavioral of Randomgen is
  signal state_now, state_next:   std_logic_vector(3 downto 0) := "1010";
  signal feedback:                std_logic;
  signal clock_line:              std_logic; 
begin

 process(clock_line, state_now, state_next)
    begin
        if rising_edge(clock_line) then
            state_now <= state_next;
        end if;
    end process;
    rand <= state_now;
    clock_line <= clock;
    feedback <= state_now(1) xor state_now(0);
    state_next <= feedback & state_now(3 downto 1);
end Behavioral;
