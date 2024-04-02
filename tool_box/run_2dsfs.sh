realSFS northern.saf.idx southern.saf.idx -fold 1 >northern_southern.folded.2dsfs -P 10 2>northern_southern.err
realSFS northern.saf.idx sierra_nevada.saf.idx -fold 1 >northern_sierra_nevada.folded.2dsfs -P 10 2>northern_sn.err
realSFS northern.saf.idx santa_cruz.saf.idx -fold 1 >northern_santa_cruz.folded.2dsfs -P 10 2>northern_sc.err
realSFS southern.saf.idx sierra_nevada.saf.idx -fold 1 >southern_sierra_nevada.folded.2dsfs -P 15 2>southern_sn.err
realSFS southern.saf.idx santa_cruz.saf.idx -fold 1 >southern_santa_cruz.folded.2dsfs -P 15 2>southern_sc.err
realSFS sierra_nevada.saf.idx santa_cruz.saf.idx -fold 1 >sierra_nevada_santa_cruz.folded.2dsfs -P 20 2>sn_sc.err