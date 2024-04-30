----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.08.2023 19:50:17
-- Design Name: 
-- Module Name: counter_wrapper - Behavioral
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

entity counter_wrapper is
 port (
       CLK:    in STD_LOGIC;
       Q:      out STD_LOGIC_VECTOR ( 3 downto 0 );
       SCLR:   in STD_LOGIC
   );
end counter_wrapper;

architecture Behavioral of counter_wrapper is
component counter is
        port (
            Q:      out STD_LOGIC_VECTOR ( 3 downto 0 );
            SCLR:   in STD_LOGIC;
            CLK:    in STD_LOGIC
        );
    end component counter;

begin
counter_i: component counter port map (CLK => CLK, Q(3 downto 0) => Q(3 downto 0), SCLR => SCLR);


end Behavioral;

