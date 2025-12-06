library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_music_player is
end tb_music_player;

architecture Behavioral of tb_music_player is
    component music_player_top is
        Port (
            MAX10_CLK1_50 : in  STD_LOGIC;
            KEY           : in  STD_LOGIC_VECTOR(1 downto 0);
            GPIO_0        : out STD_LOGIC;
            HEX0          : out STD_LOGIC_VECTOR(7 downto 0);
            HEX1          : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    signal clk_sim : std_logic := '0';
    signal key_sim : std_logic_vector(1 downto 0) := "11";
    signal audio_out : std_logic;
    signal hex0_sim : std_logic_vector(7 downto 0);
    signal hex1_sim : std_logic_vector(7 downto 0);
    
    constant CLK_PERIOD : time := 20 ns;

begin
    uut: music_player_top port map (
        MAX10_CLK1_50 => clk_sim,
        KEY => key_sim,
        GPIO_0 => audio_out,
        HEX0 => hex0_sim,
        HEX1 => hex1_sim
    );

    clk_process : process
    begin
        clk_sim <= '0';
        wait for CLK_PERIOD/2;
        clk_sim <= '1';
        wait for CLK_PERIOD/2;
    end process;

    stim_proc: process
        variable i : integer := 0;
    begin
        report "------------------------------------------------";
        report "Status: [T=0] Simulasi Dimulai. Melakukan Hard Reset...";
        key_sim(0) <= '0';
        wait for 200 ns;
        key_sim(0) <= '1';
        report "Status: Reset Selesai. Music Player harusnya mulai berjalan.";
        report "------------------------------------------------";

        wait for 5 ms;
        
        if (audio_out = 'X' or audio_out = 'Z') then
            report "FAILURE: Audio Output Undefined/High-Z!" severity failure;
        else
            report "CHECK: Sinyal Audio Valid (Logic 0/1 detected).";
        end if;

        report "Status: Menjalankan playback untuk 20 ms kedepan...";
        for i in 1 to 4 loop
            wait for 5 ms;
            report "Status: Playback progress... " & integer'image(i*5) & " ms";
        end loop;

        report "------------------------------------------------";
        report "Status: Simulasi Selesai. Silakan cek Waveform.";
        report "------------------------------------------------";
        assert false report "Simulation Finished Successfully" severity failure;
    end process;

end Behavioral;
