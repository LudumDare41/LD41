extends RigidBody

func _process(delta): 
  self.look_at(Game.player.translation, Vector3(0,1,0)) 
  var dir = Game.player.translation - self.translation 
  self.apply_impulse(Vector3(0,0,0), dir.normalized())