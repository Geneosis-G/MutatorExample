//The class name "ExampleMutatorComponent" must be changed to be iddentical to the name of this file when you rename it
class ExampleMutatorComponent extends GGMutatorComponent;

////////////////////////////////////////////////////////////////////
//This file can be used to code player behaviour for your mutator //
//Player behaviour apply to each player goat one by one			  //
////////////////////////////////////////////////////////////////////

//This is a string variable of the ExampleMutatorComponent class
var string mPlayerName;
//This is a boolean variable of the ExampleMutatorComponent class
var bool mIsReady;

//This function define what to do when the mutator it added to a player goat
//Here you might want to do some skin changes, initialize some variables, etc...
function AttachToPlayer( GGGoat goat, optional GGMutator owningMutator )
{
	//This call the same function in the parent class (GGMutatorComponent)
	//You must always use this syntax when you redefine a function that already exist in the parent class,
	//unless you want to override and lose on purpose the original behaviour of the function
	super.AttachToPlayer(goat, owningMutator);

	//mGoat contains the player goat object, it's a class variable defined in GGMutator and filled by the super.AttachToPlayer() function.
	//This ensures that the player goat object is not empty
	if(mGoat != none)
	{
		//mSlotNr containes the number of the player goat (from 0 to 3), also defined in super.AttachToPlayer()
		//Fill the mPlayerName variable depending on the goat number (add 1 so that the first goat is "Player 1" and not "Player 0")
		mPlayerName = "Player " $ (mSlotNr + 1);
		//mIsReady was false because it's not in defaultproperties, set it true now
		mIsReady=true;
		//The following line let you display some text on screen, mainly useful for debug purposes
		mGoat.WorldInfo.Game.Broadcast(mGoat, mPlayerName $ " is ready!");
	}
}

//This function is triggered every time a key is pressed or released
function KeyState( name newKey, EKeyState keyState, PlayerController PCOwner )
{
	//These are local variabled, they can only be used in this function
	//They must be defined before any other line of code in this function
	local GGPlayerInputGame localInput;
	local int currentPoints;

	if(PCOwner != mGoat.Controller)
		return;

	localInput = GGPlayerInputGame( PlayerController( mGoat.Controller ).PlayerInput );

	//In this case the key have just been pressed
	if( keyState == KS_Down )
	{
		//Call the function ShowKey()) defined below
		ShowKey(string( newKey ));

		//You can test the key with a specifik keyboard of gamepad button name
		//Keyboard letter P
		if( newKey == 'P' )
		{
			//Call AddPoints() and store its return value in currentPoints
			currentPoints = AddPoints(42);
			if(currentPoints != 0)
			{
				//currentPoints is different from zero
			}
		}
		//Gamepad button X
		else if( newKey == 'XboxTypeS_X' )
		{
			//Call AddPoints() and test the return value without storing it
			if(AddPoints(42) != 0)
			{
				//AddPoints() did not return zero
			}
		}

		//The default keys of the game have unique names so that you don't need to make the difference
		//between keyboard and gamepad, you can simply use their common name
		//This is the name for the special key (R for keyboard, Y on gamepad)
		else if( localInput.IsKeyIsPressed( "GBA_Special", string( newKey ) ) )
		{
			//AddPoints called without parameters, so default parameter value will be used
			//The return value of the function is not used here
			AddPoints();
		}
	}
	//In this case the key have just been released
	else if( keyState == KS_Up )
	{
		if( localInput.IsKeyIsPressed( "GBA_Special", string( newKey ) ) )
		{
			RemovePoints();
		}
	}
}

//This function will display the name of the key sent in parameter
//It will return no value
function ShowKey(string keyName)
{
	mGoat.WorldInfo.Game.Broadcast(mGoat, "Key=" $ keyName);
}

//This function have an optionnal parameter, so if you call it with no value, the value defined here (1) will be used
//It will return the total number of points after modification
function int AddPoints(int pointsToAdd = 1)
{
	local ExampleMutator myMutator;

	//You can access mIsReady here as well, and in any other function of this class
	if(mIsReady)
	{
		//mOwningMutator contains the ExampleMutator object related to this class, it was defined in super.AttachToPlayer() as well
		//mOwningMutator is a GGMutator container, using ExampleMutator() around it let the game know that mOwningMutator contain in fact an ExampleMutator object
		//Store the ExampleMutator object in myMutator for easy access to it
		myMutator = ExampleMutator(mOwningMutator);

		//Access the mTotalPoints variable of the ExampleMutator object, and change it
		//This syntax is a shortcut for myMutator.mTotalPoints = myMutator.mTotalPoints + pointsToAdd;
		myMutator.mTotalPoints += pointsToAdd;
		//if the total of point is bigger than the max AND if we were adding points, show a message
		//Note that the points counter is shared between players here, so all players will add points inside the same counter
		if(myMutator.mTotalPoints >= myMutator.mMaxPoints && pointsToAdd > 0)
		{
			mGoat.WorldInfo.Game.Broadcast(mGoat, "Wow " $ mPlayerName $ " got " $ myMutator.mTotalPoints $ " points!");
		}
	}

	//return the current number of points
	return myMutator.mTotalPoints;
}

//This function do not have any parameter
//It will return the total number of points after modification
function int RemovePoints()
{
	//return the value returned by AddPoints()
	return AddPoints(-1);
}

//Nothing in defaultpreperties this time, but this block must exist
DefaultProperties
{}