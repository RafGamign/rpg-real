class_name SheetParser

static func set_aseprite_sheet(spr:Variant, path:String) -> SpriteFrames:
	if path != "":
		var sprite_frames = SpriteFrames.new()
		var json = JSON.parse_string(FileAccess.get_file_as_string(path + ".json"))
		var texture = load(path + ".png")
		var sheet_data:SheetData = load(path + ".tres")
		var lengths = {}
		for stupid in json.frames.keys():
			if lengths.has(stupid.split("::")[0]):
				lengths[stupid.split("::")[0]] += 1
			else:
				lengths[stupid.split("::")[0]] = 1
		for json_frame in json.frames.keys():
			var frame_stuff = {
				anim = json_frame.split("::")[0],
				index = json_frame.split("::")[1]
			}
			var data = json.frames.get(json_frame)

			if sprite_frames.get_animation_names().find(frame_stuff.anim) == -1:
				sprite_frames.add_animation(frame_stuff.anim)
				sprite_frames.set_animation_speed(frame_stuff.anim, 12)
				sprite_frames.set_animation_loop(frame_stuff.anim, (sheet_data.looping_anims.find(frame_stuff.anim) != -1))

			if sprite_frames.get_frame_count(frame_stuff.anim) == lengths[frame_stuff.anim]:
				continue

			var frame_data:AtlasTexture
			var frame_rect:Rect2 = Rect2(
				Vector2(data.frame.x, data.frame.y),
				Vector2(data.frame.w, data.frame.h)
			)
			frame_data = AtlasTexture.new()
			frame_data.atlas = texture
			frame_data.region = frame_rect

			sprite_frames.add_frame(frame_stuff.anim, frame_data)
		
		spr.sprite_frames = sprite_frames
		spr.offset = sheet_data.sprite_offset
		return sprite_frames
	return SpriteFrames.new()
