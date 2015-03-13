--Needed items:
--Need to use I/O to navigate
--event handlers(so when the player decides to do something out of the norm.


module Adventure where

import Debug.Trace
import Data.Array (map)
import Data.List

--Currently trying to add in the characters for the game
--Will then try to create some of the objects


-- Game Types --


data Person = Person
   { name :: String
   , age :: Number 
   , relationship :: String
   }
   
newtype Thing = Thing
   { name :: String
   , edible :: Boolean
   }
   
newtype Room = Room
   { name :: String
   , people :: [Person] 
   , things :: [Thing] 
   , rooms :: [Room] 
   }


-- Type Accessors --

   
getPersonName :: Person -> String
getPersonName (Person p) = p.name

getRoomName :: Room -> String
getRoomName (Room r) = r.name

getThingName :: Thing -> String
getThingName (Thing o) = o.name
   

-- Type Data-Display Functions --

   
instance showRoom :: Show Room where
	show (Room o) = ":Room:\n " ++ show o.name ++
	"\n=ROOM DATA=" ++
	"\n:People:\n " ++ show (map (getPersonName) o.people)  ++
	"\n:Things:\n" ++ show (map (getThingName) o.things) ++
	"\n:Connected Rooms:" ++ show (map (getRoomName) o.rooms)

instance showPerson :: Show Person where
	show (Person o) = "Person: " ++ show o.name ++ " Age: " ++ show o.age ++ "\n"

instance showThing :: Show Thing where
	show (Thing o) = "Object: " ++ show o.name ++ "\nEdible: " ++ show o.edible ++ "\n"



-- Next Possible Steps:
-- Saving/Loading from JSON
-- Putting player into room
-- Allowing player basic interaction with room and its people/things
-- Structuring the program in a way that would allow the player to
--		use functions to edit people/rooms/things instead of
--		doing everything through let constructors


-- World code, doesn't work yet
--instance showWorld :: Show World where
--	show (World o) = "World: " ++ show o.name ++
--	"\n=WORLD DATA=" ++
--	"\n:Rooms:\n" ++ show (map (getRoomName) o.rooms)

-- ======================= Creating the world =========================
newtype World = World
   { name :: String
   , rooms :: [Room] 
   }

--addRoomToWorld :: Room -> World -> World
--addRoomToWorld r w = Cons r w

-- ================Adding some Code to construct the world/players/items/displaying some instructions(you guys might want to modify this=======

-- Just some basic instructions
instructions = 
	"To move around you must specify your actions in a word or two\n" ++ 
	"The available commands are:\n" ++
	"Look Around:  Check out where you're at"  ++
	"Go to ___       Which room do you want to check out?\n" ++
	"Pick Up ___     Any cool gear you want to take with you?\n" ++
	"Talk to ____    If you want to talk to someone in the room\n" ++			   
	"Tell ____       If you find someone worthy of being saved >:]\n" 
	"Stand up        Time to get going!\n" ++
	"Get ___         Get something\n" ++
	"Feed Max        Feed the Pug :3\n" ++ 
	"Call Emily      Ring Ring Ring \n" 

--
intro = "The world is going to end and you’re the only one who knows. You feel a strange urge to tell other" ++
"people that the end is nigh. At the end of the day, you discover that a race of aliens have determined " ++
"that you were the supreme ruler of Earth and have planned to destroy the planet except for you and " ++
"everyone you’ve told. They assume you will be pleased with this and you are whisked away into the " ++
"galaxy."
	
-- Let's create some characters  the ages can be re-adjusted
--The 'personYou' this can be re-adjusted once I can figure I/O out :D

personYou :: Person
personYou = { name: "You", age: 23, relationship: "you"}

personCody :: Person
personCody = {name: "Cody", age: 23, relationship: "housemate"}

personEmily :: Person
personEmily = {name: "Emily", age: 22, relationship: "roommate"}

personEllen :: Person
personEllen = {name: "Ellen", age: 28, relationship: "boss"}

personMax :: Person --Not actually a person but will help us in writing game using them as such
personMax = {name: "Max", age: 5, relationship: "dog"}


--=========Let's create some objects, do we want any attributes to these? ============
oNote :: Thing
oNote = {name: "string", edible: false} 

oCoffe :: Thing
oCoffe = {name: "coffee", edible: true}
--add more as I make way through story

nothing :: Thing
nothing = {name: "nothing", edible: false}
--============Time to set up the rooms=============------------
livingRoom :: Room 
livingRoom = {name: "Living Room", people: [personMax], things: [nothing], rooms: [bedRoom, kitchen, bathroom, houseMatesRoom]}

bedRoom :: Room
bedRoom = {name: "Bed Room", people: [personMax], things: [nothing], rooms: [livingRoom, kitchen, bathroom, houseMatesRoom]}


kitchen :: Room
kitchen = {name: "Kitchen", people: [], things: [coffee], rooms: [livingRoom, kitchen, bathroom, houseMatesRoom] }

bathroom :: Room
bathroom = {name: "Batrhoom", people: [], things: [], rooms: [livingRoom, kitchen, bedRoom, houseMatesRoom]}

houseMatesRoom :: Room
houseMatesRoom = {name: "House Mate's Room", things: [], rooms: [livingRoom, bedRoom, kitchen, bathroom]}

work :: Rooms
work = {name: "Work", things: [], rooms: [nothing]}

-- =====Need to Construct World================================

-- =====================Time to write in the story  ==========================
--Takes in what room the person is in, and returns a message, might have to readjust this for when we have many instances in one room
--This is just writing in if the user decides to do nothing. i.e. doesn't do any of the possible things just linearly moves around?
storyTell :: Room -> String
storyTell bedRoom = "You wake one foggy white morning to the alluring aroma of fresh coffee and the surprising knowledge" ++ 
"that today, the world is going to end. You’re not quite sure how you know this, but it’s a fact, written in" ++ 
"your bones and coursing through your blood. Perhaps your DNA has been wound in such a way as to " ++
"allow you this bold insight into the workings of the universe. Or perhaps you’ve gone a bit off your " ++
"rocker.\n" ++
"You yawn, and sit up."

storyTell bedRoom2 = "You look around the room that you share with your closest friend, Emily. Your eyes linger on every small" ++
"detail, aware of the fact that this may be the last time you see it. It’s neat except for a small pile of " ++
"clothes heaped onto the dresser and your dog, Max’s, leash thrown over a chair. There’s a note on your " ++
"desk that you don’t remember seeing before." --bedRoom2 is if he decides to get out of bed" 

--pt 2 if the person decides to get out of bed
--this should be an action even -- > readLetter create this function at some point.
storyTell bedRoom2 = "You grab the crumpled sheet of paper off the desk. There’s a message written in crayon that you can " ++
"barely make out—Rbhvn gt it? Gt chcit? Oh, Emily must have accidentally dropped this here, it just says, " ++
" 'remember: get chocolate.' " --At this instance there will no longer be a note item in the room

storyTell houseMatesRoom = ""

storyTell kitchen = "You follow your nose to the kitchen, where a pot of coffee sits warmly on the counter, sparkling in the" ++ 
"sunlight. At least you’ve found some beauty on this day of impending doom." ++
"Your housemate Cody sits at the counter with his face buried in a mountain of textbooks, humming a " ++ 
"tune. Despite the early hour, he already has the scent of weed on him; it mingles in the air with the " ++
"smell of earthy java. He belches, loudly. You feel uncomfortable. Your pug Max runs over to you, curled " ++ 
"tail wagging in eager expectation of breakfast."

storyTell kitchen2 = "Talking to Max would be silly, and Cody would surely make fun of you for it. You stand up as Max dives" ++ 
"into his food bowl. You think you have time for a cup of coffee before you leave, but you don’t want to " ++
"be late for your job at the boardwalk."

storyTell livingRoom = "" 

--Going to work without the coffee 

storyTell work = "So what if the world’s ending? The show must go on! You throw on your biking gear and head out the " ++ 
"door. The ride to the Santa Cruz beach boardwalk is exhilarating. The air smells like damp sand and the " ++ 
"ocean calms your fettered nerves. The boardwalk itself is a mini-amusement park, complete with rides," ++
"food vendors, and an arcade. You lock your bike your assigned locker and hurry to your shift."


-- ================================Will Implement some of the moving around functionality ===================================
--Room = Room I'm currently in --> Should be the room you're already in so you don't run into any errors. 
--String is the command that the player types in
exec_command :: Room -> String -> World
exec_command bedRoom "Go to kitchen" = "do something"--Actually take the player there
exec_command livingRoom "Go to work" =  "do something" --Actually take the player there
exec_command world.room "Pick up note" = "do something" --Where we actually go to pick up the note
exec_command world.room "Talk to Cody" = "do something" --The talk command make sure you are talking to who you can talk(expand if necessary)
exec_command world.room "Tell Cody " = "do something " --if you tell cody then the end case for that will be very different.
exec_command world.room "Tell Max " = "do something" -- end game for this 
exec_command world.room "Tell Ellen" = "do soemthing" --then do it
exec_command world.room "Tell Emily" = "do something"
exec_command world.room "Get Coffee" = "do something" 
exec_command World.rooms "Call Emily" = "do something" 