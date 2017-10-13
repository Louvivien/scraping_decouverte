require 'watir'
require 'pry'


#on va essayer d aller sur un site de se logguer et de se delogguer 
#on essaie avec les batteries du web

browser = Watir::Browser.new(:firefox)
browser.goto 'https://www.lesbatteriesduweb.fr/connexion.php'

# search_bar = browser.text_field(class: 'gsfi')

# browser.driver.manage.timeouts.implicit_wait = 3
browser.text_field(:name, 'email_address').set("team@hiwear.fr")

browser.text_field(:name, 'password').set("Merde972")

#et on simule le click sur le bouton !
browser.button(:title," Accéder à mon compte ").click

#binding.pry

# et si on veux se délogguer :
#  - on va sur la page de delogg , donc cliquer
browser.as(:id,'lt_onglete')[3].click

#binding.pry

# puis on reclique sur l element contenant "cliquer ici", on va utiliser xpath pour changer
#pour cela on appelle "element" car on n'est pas censé le connaitre 
el= browser.element(:xpath => "//td[@class='main']//a[@href='https://www.lesbatteriesduweb.fr/deconnexion.php'").click
