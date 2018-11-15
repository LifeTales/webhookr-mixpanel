class MixpanelHooks

  # All 'on_' handlers are optional. Omit any you do not require.
  # Details on the payload structure: http://help.example_plugin.com/entries/24466132-Webhook-Format

  def on_give_story(incoming)
    payload = incoming.payload
    puts("on_give_story: #{payload.inspect}")
  end

end
