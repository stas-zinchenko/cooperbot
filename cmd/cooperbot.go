package cmd

import (
	"fmt"
	"log"
	"time"

	"github.com/spf13/cobra"
	telebot "gopkg.in/telebot.v3"
)

var (
	//TeleToken bot
	TeleToken = "6247607846:AAGF5NIxZdv7jDMRR4eDh0CWtmvP9N5IJD4"
)

// cooperbotCmd represents the cooperbot command
var cooperbotCmd = &cobra.Command{
	Use:     "cooperbot",
	Aliases: []string{"start"},
	Short:   "A brief description of your command",
	Long: `A longer description that spans multiple lines and likely contains examples
and usage of using your command. For example:

Cobra is a CLI library for Go that empowers applications.
This application is a tool to generate the needed files
to quickly create a Cobra application.`,
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Printf("cooperbot %s started", appVersion)
		cooperbot, err := telebot.NewBot(telebot.Settings{
			URL:    "",
			Token:  TeleToken,
			Poller: &telebot.LongPoller{Timeout: 10 * time.Second},
		})

		if err != nil {
			log.Fatalf("Please check TELE_TOKEN env variable. %s", err)
			return
		}

		//cooperbot.Handle(telebot.OnText, func(m telebot.Context) error {
		//	log.Print(m.Message().Payload, m.Text())
		//	payload := m.Message().Payload

		//	switch payload {
		//	case "hello":
		//		err = m.Send(fmt.Sprintf("Hello. I'm Cooperbot %s!", appVersion))
		//	}

		//	return err
		//})

		cooperbot.Handle("/start", func(m telebot.Context) error {
			return m.Reply(fmt.Sprintf("Hello. I'm Cooperbot %s!", appVersion))

		})

		cooperbot.Handle("/about", func(m telebot.Context) error {
			return m.Reply("My purpose is to tell everything about our Galaxy.")

		})
		cooperbot.Handle("/galaxy", func(m telebot.Context) error {
			return m.Reply("https://en.wikipedia.org/wiki/Milky_Way")

		})

		cooperbot.Handle("/sun_system", func(m telebot.Context) error {
			return m.Reply("https://en.wikipedia.org/wiki/Solar_System")

		})

		cooperbot.Handle("/planets", func(m telebot.Context) error {
			return m.Reply("https://www.youtube.com/watch?v=libKVRa01L8")

		})

		cooperbot.Start()
	},
}

func init() {
	rootCmd.AddCommand(cooperbotCmd)

	// Here you will define your flags and configuration settings.

	// Cobra supports Persistent Flags which will work for this command
	// and all subcommands, e.g.:
	//cooperbotCmd.PersistentFlags().String("foo", "", "A help for foo")

	// Cobra supports local flags which will only run when this command
	// is called directly, e.g.:
	// cooperbotCmd.Flags().BoolP("toggle", "t", false, "Help message for toggle")
}
