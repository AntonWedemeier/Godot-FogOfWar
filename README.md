# Godot-FogOfWar

This is a generally usable Scene for generating a fog of war. The Scene can be  added to a (2D) game, made with the [Godot Engine](https://godotengine.org/.

I made this and tested it with Godot version 3.0.6 on Windows.
I used this for an isometric 'game' I was experimenting with.

## Fog of war
This 'fog of war' starts with a texture filled with an opaque color for covering the entire play field. The fog dissolves around the player. At the places the player was before the fog stays away.

Because of that this Scene can not be used for unlimmited worlds and for games where the fog returns after a some time.

## What it does
At the start of a new level, I ceate a texture of a given size and fill it with an opaque color (or partially transparent). The game informs the FogOfWar Scene about the positions of the player; at that location the fog dissolves.

For dissolving the fog I made a texture (with Paint.net) with a gradient. This texture defines how much the fog dissolves: black dissolves the fog completely, gray only partly, and white of alphas < 1 does nothing. 
In fact I use the red channel of this texture; the red-value defines the alpha value to set to the fog texture.

## How it works
The root-node of this Scene is the ‘FogOfWar’ node. This is also the interface for the game application (see below). The Scene has the following node structure:

    FogOfWar
        ViewportFog
            Fog
        FogTexture

The node ‘Fog’ is the node which holds and changes the fog texture. With every process step of the game engine this Fog node uses the texture from the ‘ViewportFog’; the viewport holds the last shown texture. The Fog node updates this last shown texture and the changed texture is shown again inside the viewport. The node ‘FogTexture’ gets its texture from the the ‘ViewportFog’. The ‘FogTexture’ is shown in the scene-tree of the game holding the FogOfWar scene.

# How to use
Simply add the FogOfWar Scene to the game. It must be low inside the Scene tree because it must be rendered after the play field and player.

The most simple structure could be:

    Stage node
        Background node
        FogOfWar Scene

All the interfacing can be done through the root-node of the FogOfWar Scene: the FogOfWar node. Please check out the FogOfWar.gd script file.

The setup of all the other nodes is done within the scripts, so a user of this ‘FogOfWar’ Scene normally does not have to setup the other nodes himself.

When the game starts a new level, then, after loading a new level, the game must call the function ‘level_start’. Calling this function creates a new fog texture filled with the fog-color. The size of the fog-texture is given inside the call as well the position. A scale can be given to make a smaller texture but covering the given size. This smaller texture makes it more coarser.

Inside the process-step the players position is given through the function ‘set_clear_position’. The FogOfWar Scene dissolves the fog at the given position.

Inside the script of the ‘Fog’ node there are values for the fog-color and the texture used for clearing the fog around the clearing position. These values can be changed inside the ‘Fog’ script, but preferably with a function call to a function inside the interface node: FogOfWar.gd.





