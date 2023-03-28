package stx.di.test;

// class TestInheritance extends Case {
// 	public function testChangeHead() {
// 		var di = new DI();
// 		di.add(Head.new);
// 		di.add(() -> new Tail(1));
// 		di.run((head:Head) -> trace(head));
// 		var di2 = di.extend();
// 		di2.add(() -> new Tail(2), true);
// 		di2.run((head:Head) -> trace(head));
// 	}
// }

// class Head {
// 	public function new(tail) {
// 		this.tail = tail;
// 	}

// 	var tail:Tail;
// }

// class Tail {
// 	var id:Int;

// 	public function new(id) {
// 		this.id = id;
// 	}
// }