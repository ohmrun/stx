(require 'stx_release/release :reload)
(require '[babashka.process :as proc])
(def dirs (release/directories_absolute))
(defn make_pb [dir] (proc/pb {:dir dir :out :string} "hedn" "build" "unit/interp"))

(defn b [] (apply proc/pipeline (vec (map make_pb dirs))))
(map (fn [x] {:err (-> x :err slurp) :out (-> x :out slurp)}) (b))