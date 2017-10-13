require 'watir'


browser = Watir::Browser.new(:firefox)
browser.goto 'google.com'

search_bar = browser.text_field(class: 'gsfi')

search_bar.set("hiwear")

# en le faisant par simulation de l'appui sur la touche entrée 
#search_bar.send_keys(:enter)

#en simulant appui sur loupe de google
submit_button = browser.button(type:"submit")
submit_button.click

