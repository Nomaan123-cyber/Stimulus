----------------------------------------------------------------------------------
-- Company: The Avengers
-- Engineer: Nomaan, Kingsley
-- 
-- Create Date: 
-- Design Name: 
-- Module Name: final_result - Behavioral
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
use IEEE.NUMERIC_STD.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity final_result is
    Port(
      start_button: in std_logic;
      clear_button: in std_logic;
      stop_button: in std_logic;
      clock_1: in std_logic;

      seven_seg_anode: out std_logic_vector(7 downto 0);
      seven_seg_cathode: out std_logic_vector(7 downto 0);
  
      led:out std_logic_vector(2 downto 0)
      );
end final_result;

architecture Behavioral of final_result is

 component capncomp is
        Port (
            clock_3:      in std_logic;
            random_number:  in std_logic_vector(3 downto 0);
            control:        in std_logic;
            count_reached:  out std_logic
        );
    end component;

    component Randomgen is
        port (
            rand:   out std_logic_vector(3 downto 0);
            clock:  in std_logic
        );
    end component;

    component Clockdivider is
        port (
            clock_1: in std_logic; --Clock 1 = 100MHz
            clock_2: out std_logic; -- Clock 2 = 1000Hz(1KHz)
            clock_3:    out std_logic;-- Clock 3 = 1Hz
            clock_4: out std_logic -- Clock 4 = 8000Hz(8KHz)
        );
    end component;
 
     component Sevensegmentd is
        Port (clk_4 : in std_logic;
              one_mils : in integer;
              ten_mils : in integer;
              hundred_mils : in integer;
              one_sec : in integer;
              f_state : in std_logic_vector(2 downto 0);
              anode : out std_logic_vector(7 downto 0);
              cathode : out std_logic_vector(7 downto 0)
          );
    end component;
    
    component Milsecounter is
          Port (clk_2 :in std_logic;
                clear_button : in std_logic;
                stop_button : in std_logic;
                f_state : in std_logic_vector(2 downto 0);
                one_mils : out integer;
                ten_mils : out integer;
                hundred_mils : out integer;
                one_sec : out integer;
                count_done : out std_logic
                );
    end component;
 
 
    type state_type is (init, rand_wait, count, err, hold);
    signal f_state : state_type := init;
    signal f_state_parse: std_logic_vector(2 downto 0); 

    signal clock_3_line:      std_logic;
    signal clock_2_line:     std_logic;
    signal clock_4_line:     std_logic;
    signal clock_1_line:   std_logic;

    signal bus_random_number:   std_logic_vector(3 downto 0);

    signal control_store_or_load:   std_logic;      
    signal control_count_reached:   std_logic;      
    
    signal reaction_time:   std_logic_vector(11 downto 0);  

    signal one_mils_bus, ten_mils_bus, hundred_mils_bus, one_sec_bus: integer; 
    signal count_done_bus : std_logic;
begin

    clock_1_line <= clock_1;
    
Signalcount: capncomp port map(clock_3=>clock_3_line, random_number=>bus_random_number, control=>control_store_or_load, count_reached=>control_count_reached);
Random_gen: Randomgen port map(rand=>bus_random_number, clock=>clock_1_line);
Clock_divider: Clockdivider port map(clock_1=>clock_1_line, clock_2=>clock_2_line, clock_3=>clock_3_line, clock_4=>clock_4_line);
Seven_segmentd:  Sevensegmentd port map (clk_4=>clock_4_line, one_mils=>one_mils_bus, ten_mils=>ten_mils_bus, hundred_mils=>hundred_mils_bus, one_sec=>one_sec_bus, f_state=>f_state_parse, anode=>seven_seg_anode, cathode=>seven_seg_cathode);
Mil_secounter: Milsecounter port map (clk_2 => clock_2_line, clear_button => clear_button, stop_button => stop_button, f_state => f_state_parse, one_mils => one_mils_bus, ten_mils => ten_mils_bus, hundred_mils => hundred_mils_bus, one_sec => one_sec_bus, count_done => count_done_bus);



STATE_HANDLER:    process (clock_1_line, clear_button, stop_button, start_button)
    begin
        if (clear_button='1') then
            f_state <= init;
            led <= "000";      
        elsif rising_edge(clock_1_line) then
            case f_state is
                when init =>
                    control_store_or_load <= '1';
                    f_state_parse <= "000";
                    if (start_button='1') then
                        f_state<=rand_wait;
                       
                    end if;
                    
                when rand_wait =>
                    f_state_parse <= "001";
                    control_store_or_load <= '0';   
                    if (stop_button='1') then
                        f_state <= err;
                    elsif (clear_button='1') then
                        f_state <= init;
                    elsif (control_count_reached='1') then
                        f_state <= count;
                    end if;
                when count =>
                
                    led <= "111";
                    f_state_parse <= "010";
                    control_store_or_load <= '1';
                    if (stop_button='1') then
                        f_state<=hold;
                    elsif (clear_button='1') then
                        f_state<=init;
                    
                    elsif (count_done_bus = '1') then
                        f_state<=hold; 
                    end if;
                    
                when err =>
                    f_state_parse <= "011";
                    control_store_or_load <= '1';
                    if (clear_button='1') then
                        f_state<=init;
                    end if;
                when hold =>
                    f_state_parse <= "100";
                    led <= "000";
                    control_store_or_load <= '1';
                    if (clear_button='1') then
                        f_state<=init;
                    end if;
                when others =>
                    f_state <= init;
                    control_store_or_load <= '1';
            end case;
        end if;
    end process;
    


end Behavioral;
