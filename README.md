# Godot-FogOfWar

The FogOfWar Scene is a generally usable Scene for generating a fog of war. The Scene can be  added to a (2D) game, made with the [Godot Engine](https://godotengine.org/).

I made this and tested it with Godot version 3.0.6 on Windows.
I used this for an isometric 'game' I was experimenting with.

## Fog of war
This 'fog of war' starts with a texture filled with an opaque (or almost apaque) color for covering the entire play field. The fog dissolves around the player. At the places the player was before the fog stays away.

Because of that this Scene can not be used for unlimmited worlds and for games where the fog returns after a some time.

## What it does
At the start of a new level, A new texture is created of a given size and then filled with the opaque (or partially transparent) fog-color. When the game informs the FogOfWar Scene about the positions of the player the fog dissolves at that location.

For dissolving the fog a seperate small texture is used. This texture defines how much the fog dissolves: black dissolves the fog completely, gray only partly, and white of alphas < 1 does nothing. In fact I use the red channel of this texture; the red-value defines the alpha value to set to the fog texture.

I made a texture (with [Paint.net](https://www.getpaint.net/)) with a gradient. This texture, "FogGradient.png", is inside the FogOfWar folder. You can give your own texture.

## How it works
The root-node of this Scene is the 'FogOfWar' node. This is also the interface for the game application (see below). This Scene has the following node structure:

    FogOfWar
        ViewportFog
            Fog
        FogTexture

The node ‘Fog’ is the node which holds and changes the fog texture. With every process step of the game engine this Fog node uses the texture from the ‘ViewportFog’; at that moment the viewport holds the last shown fog texture. The 'Fog' node updates this last shown texture and the changed texture appers again inside the viewport. The node ‘FogTexture’ gets its texture from the the ‘ViewportFog’. This ‘FogTexture’ is shown in the scene-tree of the game holding the FogOfWar scene.

# How to use
Simply add the FogOfWar Scene to the game. It must be low inside the Scene tree because it must be rendered after the play field and player.

The most simple structure could be:

    Stage node
        Background node
        FogOfWar Scene

All the interfacing can be done through the root-node of the FogOfWar Scene: that is "FogOfWar" node. Please check out the "FogOfWar.gd" script file inside the FogOfWar folder.

The setup of all the other nodes is done within the scripts, so a user of this "FogOfWar" Scene normally does not have to setup the other nodes himself.

When the game starts a new level, after loading this new level, the game must call the function ‘level_start’. Calling this function creates a new fog texture filled with the fog-color. The size of the fog-texture is given inside the call as well the position. A scale can be given to make a smaller texture but covering the given size. This smaller texture makes the fog dissolving more coarser. Because a shader is used, I do not think there is any performance penalty for large textures. But the hardware can be limited to load too large textures.

Inside the process-step the players position is given through the function ‘set_clear_position’. The FogOfWar Scene dissolves the fog at the given position.

Inside the script of the ‘Fog’ node there are already values for the fog-color and for the texture used for clearing the fog around the clearing position. These values can be changed inside the ‘Fog’ script, but preferably with a function call to a function inside the interface node: FogOfWar.gd.

# Demo
As a demo I made a Godot project. Downloading the content of this site into an **empty** folder on your computer. Open the project file: project.godot and run the game. The 'player' can be controlled with the arrow keys.

![demo screen shot](https://github.com/AntonWedemeier/Godot-FogOfWar/blob/master/demo.png)




