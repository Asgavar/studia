module type VERTEX =
sig
  type t
  type label
  val equal : t -> t -> bool
  val create : label -> t
  val label : t -> label
end


module type EDGE =
sig
  type t
  type vertex_t
  type label
  val equal : t -> t -> bool
  val from_vertex : t -> vertex_t
  val to_vertex : t -> vertex_t
end


module StringVertex : VERTEX =
struct
  type label = string
  type t = Vrtx of label
  let equal v1 v2 =
    match (v1, v2) with
      (Vrtx l1), (Vrtx l2) when l1 = l2 -> true
    | _ -> false
  let create lbl = Vrtx lbl
  let label vrtx = match vrtx with Vrtx lbl -> lbl
end


module StringEdge : EDGE =
struct
  type vertex_t = StringVertex.t
  type t = Edge of vertex_t * vertex_t
  type label = string
  let equal e1 e2 =
    match (e1, e2) with
      (Edge (from1, to1), Edge (from2, to2)) when from1 = from2 && to1 = to2 -> true
    | _ -> false
  let from_vertex edge =
    match edge with
      Edge (from_vrtx, _) -> from_vrtx
  let to_vertex edge =
    match edge with
      Edge (_, to_vrtx) -> to_vrtx
end
