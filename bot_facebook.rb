#!/usr/bin/env ruby

#bot Facebook qui va récupérer la liste de toutes les membres d'un groupe Facebook, avec nom et url
#fonctionne avec Facebook du 20171013

require 'watir'
require 'pry'


#url du groupe facebook a suivre : les francais de bogota
#page_url="https://www.facebook.com/groups/214718712053384/members"

class Facebook_scrap

	attr_accessor :browser

	def initialize(page_url)
		#on definit ici les valeurs par defaut a la creation de la class
		@page_url = page_url
		#on definit le navigateur a utiliser une bonne fois pour toute:
		@browser = Watir::Browser.new(:firefox)
	end

	#ne marchera pas, car en dehors d'un programme:
	#on va sur la page de groupes voulue , mais non loggué => il ft se logguer
	#@browser.goto @page_url

	#on definit une fonction qui se log sur facebook
	def log_in_to_facebook()
		#a tout hasard on propose d'aller sur la page
		@browser.goto "https://www.facebook.com/login/"

		#on rentre nos identifiants
		# => appel de nos identifiants caches qque part !! lol
		load '/home/brice/Documents/THP/S02J5/secret.rb'

		#et on les tape :
		@browser.text_field(id: 'email').set(Email_fb)
		@browser.text_field(id: 'pass').set(Pwd_fb)
		#et on clique :
		@browser.button(:id,"loginbutton").click
	end

	#on definit une fct qui va sur les groupes
	def fb_grp_scrap()
		@browser.goto @page_url

		#on doit cliquer sur "see more" afin de charger tte la page (ds mon FB, il se gere automatiquement)
		#on va cliquer sur l element TANT QUE il est present (marche aussi pour visible, exists)

		#ya une popup qui arrive et qui m'emmerde, on va essayer de la degager:
		#browser.element(:xpath => "//h3[@class='_52c9']")
		#@browser.execute_script("window.scrollBy(0,20000)")
		while true # ou visible? exists?

			#le begin afin de gerer l erreur sur le temps ecoule
			begin
				#possibilite de virer la popup facebook
				puts "popup s affiche" if browser.alert.present?
				binding.pry
				# @browser.alert.ok.click if browser.alert.present?
				# # Remove the function
				# @browser.execute_script("window.onbeforeunload = null")
				# # Then trigger the action that leaves the page
				# @browser.link.click

				popup_fb= @browser.element(:xpath => "//a[@class='layerCancel _4jy0 _4jy3 _517h _51sy _42ft']")
				if popup_fb.present?
					puts "popup presente"
					popup_fb.click
				end


				link_see_more = @browser.element(:xpath => "//a[@class='pam uiBoxLightblue uiMorePagerPrimary']")
				link_see_more.click
				#sleep(3)				

				#condition de sortie de la boucle infinie : il n'y a plus le bouton see more
				if link_see_more.present? == false
					puts "plus de see more on sort de l infinie"
					break
				end
			rescue Watir::Exception::UnknownObjectException, Watir::Wait::TimeoutError
				puts "tps depasse dans boucle infinie"
			end #fin begin
		end
		#binding.pry
	end


end #fin de la class

#fr en bogota:
#page_url = "https://www.facebook.com/groups/214718712053384/members"
page_url="https://www.facebook.com/groups/1565896396963524/members"
bot=Facebook_scrap.new(page_url)

bot.log_in_to_facebook()

bot.fb_grp_scrap()
