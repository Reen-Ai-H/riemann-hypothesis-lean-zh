-- 公理检查文件（本仓库新增，不属于作者原始压缩包）
-- 用法：先 `lake build Main`，再运行 `lake env lean Check.lean`
--
-- 合格的输出里只应出现 Lean 的三条标准公理：
--   propext, Classical.choice, Quot.sound
-- 如果出现 sorryAx、Lean.ofReduceBool 或其他自定义 axiom，说明证明依赖了未经证明的东西。

import Main

#print axioms riemannHypothesis
#print axioms riemannZeta_eq_zero_re
#print axioms LFunction_ne_zero_of_half_lt_re
#print axioms LFunction_eq_zero_re
#print axioms LFunction_eq_zero_re_of_isPrimitive
