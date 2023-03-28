package stx.ds;

typedef XSetKeyComparable<K,V>    = stx.assert.ds.xset.comparable.term.XSetKey<K,V>;
typedef XSetKeyEq<K,V>            = stx.assert.ds.xset.eq.term.XSetKey<K,V>;
typedef XSetKeyOrd<K,V>           = stx.assert.ds.xset.ord.term.XSetKey<K,V>;

typedef XSetValComparable<K,V>    = stx.assert.ds.xset.comparable.term.XSetVal<K,V>;
typedef XSetValEq<K,V>            = stx.assert.ds.xset.eq.term.XSetVal<K,V>;
typedef XSetValOrd<K,V>           = stx.assert.ds.xset.ord.term.XSetVal<K,V>;

typedef XSetComparable<K,V>       = stx.assert.ds.xset.comparable.term.XSet<K,V>;
typedef XSetEq<K,V>               = stx.assert.ds.xset.eq.term.XSet<K,V>;
typedef XSetOrd<K,V>              = stx.assert.ds.xset.ord.term.XSetKey<K,V>;

typedef XSetWithComparable<K,V>   = stx.assert.ds.xset.comparable.term.XSetWith<K,V>;
typedef XSetWithEq<K,V>           = stx.assert.ds.xset.eq.term.XSetWith<K,V>;
typedef XSetWithOrd<K,V>          = stx.assert.ds.xset.ord.term.XSetWith<K,V>;

typedef XSetPlaceComparable       = stx.assert.ds.xset.comparable.term.XSetPlace;
typedef XSetPlaceEq               = stx.assert.ds.xset.eq.term.XSetPlace;
typedef XSetPlaceOrd              = stx.assert.ds.xset.ord.term.XSetPlace;

typedef With<K,V>                 = stx.ds.xset.With<K,V>;
typedef XSet<K,V>                 = stx.ds.xset.XSet<K,V>;
typedef XSetPlaceSum              = stx.ds.xset.XSetPlace.XSetPlaceSum;
typedef XSetPlace                 = stx.ds.xset.XSetPlace;

typedef XSetTree                  = stx.ds.xset.XSetTree;
typedef XSetTreeType              = stx.ds.xset.XSetTreeType;
typedef XSetTreeData              = stx.ds.xset.tree.XSetTreeData;
typedef XSetTreeDataCluster       = stx.ds.xset.tree.XSetTreeDataCluster;
typedef XSetTreeValDef            = stx.ds.xset.tree.XSetTreeVal.XSetTreeValDef;
typedef XSetTreeVal               = stx.ds.xset.tree.XSetTreeVal;

typedef XSetVal<K,V>              = stx.ds.xset.XSetVal<K,V>;
typedef XSetValSum<K,V>           = stx.ds.xset.XSetVal.XSetValSum<K,V>;

typedef XSetWith<K,V>             = stx.ds.xset.XSetWith<K,V>;
typedef XSetWithState             = stx.ds.xset.XSetWithState;