# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

b1 = Brewery.create name: "Koff", year: 1897
b2 = Brewery.create name: "Malmgard", year: 2001
b3 = Brewery.create name: "Weihenstephaner", year: 1042
b4 = Brewery.create name: "BrewDog", year: 2007

s1 = Style.create name: "Hefeweizen", description: "A south German style of wheat beer (weissbier) made with a typical ratio of 50:50, or even higher, wheat. A yeast that produces a unique phenolic flavors of banana and cloves with an often dry and tart edge, some spiciness, bubblegum or notes of apples. Little hop bitterness, and a moderate level of alcohol. The \"Hefe\" prefix means \"with yeast\", hence the beers unfiltered and cloudy appearance. Poured into a traditional Weizen glass, the Hefeweizen can be one sexy looking beer. Often served with a lemon wedge (popularized by Americans), to either cut the wheat or yeast edge, which many either find to be a flavorful snap ... or an insult and something that damages the beer's taste and head retention."
s2 = Style.create name: "Munich Helles Lager", description: "When the golden and clean lagers of Plzen (Bohemia) became all the rage in the mid-1800's, München brewers feared that Germans would start drinking the Czech beer vs. their own. Munich Helles Lager was their answer to meet the demand. A bit more malty, they often share the same spicy hop characters of Czech Pils, but are a bit more subdued and in balance with malts. \"Helles\" is German for \"bright.\""
s3 = Style.create name: "English Pale Ale", description: "The English Pale Ale can be traced back to the city of Burton-upon-Trent, a city with an abundance of rich hard water. This hard water helps with the clarity as well as enhancing the hop bitterness. This ale can be from golden to reddish amber in color with generally a good head retention. A mix of fruity, hoppy, earthy, buttery and malty aromas and flavors can be found. Typically all ingredients are English."
s4 = Style.create name: "English India Pale Ale (IPA)", description: "First brewed in England and exported for the British troops in India during the late 1700s. To withstand the voyage, IPA's were basically tweaked Pale Ales that were, in comparison, much more malty, boasted a higher alcohol content and were well-hopped, as hops are a natural preservative. Historians believe that an IPA was then watered down for the troops, while officers and the elite would savor the beer at full strength. The English IPA has a lower alcohol due to taxation over the decades. The leaner the brew the less amount of malt there is and less need for a strong hop presence which would easily put the brew out of balance. Some brewers have tried to recreate the origianl IPA with strengths close to 8-9% abv."
s5 = Style.create name: "Low Alcohol Beer", description: "Low Alcohol Beer is also commonly known as Non Alcohol (NA) beer, which is a fallacy as all of these beers still contain small amounts of alcohol. Low Alcohol Beers are generally subjected to one of two things: a controlled brewing process that results in a low alcohol content, or the alcohol is removed using a reverse-osmosis method which passes alcohol through a permeable membrane."
s6 = Style.create name: "Baltic Porter", description: "Porters of the late 1700's were quite strong compared to todays standards, easily surpassing 7% alcohol by volume. Some brewers made a stronger, more robust version, to be shipped across the North Sea, dubbed a Baltic Porter. In general, the styles dark brown color covered up cloudiness and the smoky/roasted brown malts and bitter tastes masked brewing imperfections. The addition of stale ale also lent a pleasant acidic flavor to the style, which made it quite popular. These issues were quite important given that most breweries were getting away from pub brewing and opening up breweries that could ship beer across the world."

r1 = b1.beers.create name: "Iso 3", style: s2
b1.beers.create name: "Karhu", style: s2
b1.beers.create name: "Tuplahumala", style: s2
b2.beers.create name: "Huvila Pale Ale", style: s3
b2.beers.create name: "X Porter", style: s6
b3.beers.create name: "Hefeweizen", style: s1
b3.beers.create name: "Helles", style: s2
r2 = b4.beers.create name: "Punk IPA", style: s4
r3 = b4.beers.create name: "Nanny State", style: s5

r1.ratings.create score: 10
r1.ratings.create score: 21
r1.ratings.create score: 17
r3.ratings.create score: 2
r3.ratings.create score: 11
r2.ratings.create score: 12
r2.ratings.create score: 24



