#pragma once
#include "stdafx.h"
#include "../ZModule.h"

class BlitzAbility_Hunter : ZModule
{
public:
	DECLARE_ID(ZMID_HUNTER)
	BlitzAbility_Hunter();
	~BlitzAbility_Hunter();

	virtual bool Update(float elapsedtime) override;
	virtual void Active(bool bActive = true);	// (��)Ȱ��ȭ ��Ų��

private:
	float honorincratio;
};